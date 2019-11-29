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
            outrow2 = re_replace(outrow1, re_rules['find_str_2'], re_rules['replace_str_2'])
            outrow3 = re_replace(outrow2, re_rules['find_str_3'], re_rules['replace_str_3'])
            outrow4 = re_replace(outrow3, re_rules['find_str_4'], re_rules['replace_str_4'])
            outrow5 = re_replace(outrow4, re_rules['find_str_5'], re_rules['replace_str_5'])
            fo.write(outrow5)
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
    filepath         = '../projects/Fake-Names-20191122/2-prepared-data/FakeNames-ed.csv'
    targetfile       = '../projects/Fake-Names-20191122/2-prepared-data/FakeNames-ed_re.csv'
    re_rules                    = {}
    re_rules['find_str_1']     = '\"\$'         # Find $ sign.
    re_rules['replace_str_1']  = '"'            # Replace $ sign with empty.
    re_rules['find_str_2']     = ';[ \\t]'      # Find semicolon (;) + whitespace.
    re_rules['replace_str_2']  = '. '           # Replace semicolon (;) with a dot.
    re_rules['find_str_3']     = '\(KHTML,'     # Find string "(KHTML"
    re_rules['replace_str_3']  = '(KHTML.'      # Replace string "(KHTML" with "(KHTML."
    re_rules['find_str_4']     = ',\"[0-9]+,'   # Find comma (,) + a number sequense.
    re_rules['replace_str_4']  = ',"[0-9]'      # Replace comma (,) + a number sequence with number.
    re_rules['find_str_5']     = ';\\n'         # Find semicolon (;) + next row sign.
    re_rules['replace_str_5']  = '\n'           # Replace semicolon (;) + next row sign withj next row sign.

    process_csv_file(filepath, targetfile, re_rules)

if __name__ == "__main__":
    main()
