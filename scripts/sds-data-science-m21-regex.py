import re
import pandas as pd
import csv


def re_replace(inrow, find_str, replace_str):
    """ Take inrow, find and replacefind_str with replace_str.
        Return modified row.
    """
    print(f'ROW: {inrow}')
    print(f'Find: {find_str} | Replace: {replace_str}')
    fs = str(find_str)
    rs = str(replace_str)
    ir = str(inrow)
    row_out = re.sub(fs, rs, ir)
    print(f'OUT: {row_out}\n')
    return row_out

def process_csv_file(filepath, targetfile, re_rules):
    """Process input data (1 CSV file) and create targetfile.

    Keyword arguments:
    * filepath --   path to CSV file to be processed.

    Output:
    * targetfile -- processed CSV file.
    """
    print(f'Start processing: {filepath}.')
    print(f'Storing modified result to: {targetfile}')

    num_lines_1 = 0
    csv.register_dialect(   'myDialect', \
                            quoting=csv.QUOTE_MINIMAL, \
                            skipinitialspace=True)
    with open(filepath, 'r', encoding = 'utf8', newline='') as fi, \
        open(targetfile, 'w+', encoding='utf8', newline='') as fo:
        for row in fi:
            outrow1 = re_replace(row, re_rules['find_str_1'], re_rules['replace_str_1'])
            fo.write(outrow1)
            num_lines_1 += 1
        print('Processed lines: ', num_lines_1)
        print(f'Data processed successfully into targetfile: {targetfile}.')
    return

def main():
    """ Open CSV file, find + replace wanted strings, store results to a new file.

    Keyword arguments:
    * None

    Output:
    * All input data is modified and results stored to a new file.
    """
    filepath         = '../projects/SQL-Practise-Datasets-20200128/2-prepared-data/PART3-S5-OrderBreakdown.csv'
    targetfile       = '../projects/SQL-Practise-Datasets-20200128/2-prepared-data/PART3-S5-OrderBreakdown-re.csv'
    re_rules                    = {}
    re_rules['find_str_1']     = ', '           # Find comma (,) + a number sequense.
    re_rules['replace_str_1']  = ' - '      # Replace comma (,) + a number sequence with number.

    process_csv_file(filepath, targetfile, re_rules)

if __name__ == "__main__":
    main()
