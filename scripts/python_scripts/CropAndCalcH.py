import csv,pickle,argparse,os,time,re
from collections import defaultdict,Counter



def BED_Reader(bed_file):
    content=defaultdict(list)

    with open(bed_file) as f:
        bed_csv=csv.reader(f,dialect=csv.excel_tab)
        for line in bed_csv:
            content[line[0]].append([int(line[1]),int(line[2]),line[5]])
    for i in content:
        content[i].sort(key=lambda x:x[0])
    return content

def MapBedToSeqAndCrop(bed_content,chrfolderls,chrls,adj):
    for i in range(len(chrfolderls)):
        for seqfilename in os.listdir(chrfolderls[i]):
            if os.path.splitext(seqfilename)[1]=='.seq':
                with open(os.path.join(chrfolderls[i],seqfilename)) as seqfile:
                    for posinfo in bed_content[chrls[i]]:
                        try:
                            seqfile.seek(posinfo[0]-adj)
                            upstream=seqfile.read(adj)
                            TSS=seqfile.read(posinfo[1]-posinfo[0])
                            downstream=seqfile.read(adj)
                        except Exception as e:
                            upstream,TSS,downstream='','',''
                            print('failed to read '+seqfilename+' '+str(posinfo[0]))
                        if len(posinfo)==3:
                            posinfo.append([])
                        posinfo[3].append([TSS,upstream,downstream])
                print('Finish Reading '+seqfilename)

    pass

def h_calc_for_seqs(seqs):
    h_list=[]
    for i in zip(*seqs):
        frq=Counter(i)
        n=len(i)-frq['-']-frq['N']-frq['?']
        if len(set(frq.keys()) - set(['N','-','?']))>1:
            for c in ['?','-','N']:
                if c in frq:
                    frq.pop(c)
            h_list.append((1-sum([(float(frq[i])/n)**2 for i in frq]))*n/(n-1))
        else:
            h_list.append(0.)
    return h_list

def calc_h_for_entire_dataset(content,chrls):
    count=0
    for chr in chrls:
        chrc=content[chr]
        for tss in chrc:
            TSSseq=tss[3]
            hh_list=[h_calc_for_seqs(i) for i in zip(*TSSseq)]
            tss.append(hh_list)
            count+=1
            if count%100==0:
                print('%i sites has been calculated'%(count))
    pass
def SaveData(content,chrls):
    with open('AllData.pickle','wb') as f:
        pickle.dump(content,f)
    with open('h_summary.csv','w') as f:
        cf=csv.writer(f)
        for chr in chrls:
            for tss in content[chr]:
                cf.writerow([str(chr),str(tss[0]),str(tss[1]),tss[2],' '.join([repr(i) for i in tss[4][0]])])
    pass


if __name__=='__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('bedfilename',help='input bed file name')
    parser.add_argument('seqfolder',help='seq folder')
    parser.add_argument('adjacent',help='how many bases should we calc for adjacent region')
    args=parser.parse_args()

    content=BED_Reader(args.bedfilename)

    t=time.clock()

    chrls=['chr2L','chr2R','chr3L','chr3R','chrX']
    #chrls=['chr2L','chr2R']
    folderls=[None]*len(chrls)
    for i in os.listdir(args.seqfolder):
        folder_name_match=re.search(r'Chr.+$',i)
        if folder_name_match is not None:
            folder_name_chr_tail=folder_name_match.group(0)
            folder_name_chr_tail='c'+folder_name_chr_tail[1:]
            if folder_name_chr_tail in chrls:
                folderls[chrls.index(folder_name_chr_tail)]=os.path.join(args.seqfolder,i)
    MapBedToSeqAndCrop(content,folderls,chrls,int(args.adjacent))
    print('finish file processing, time cost=%f seconds'%(time.clock()-t))
    t=time.clock()
    print('begin calculating h')
    calc_h_for_entire_dataset(content,chrls)
    print('finish h calculating, time cost=%f seconds'%(time.clock()-t))
    t=time.clock()
    print('begin to save data')
    SaveData(content,chrls)

