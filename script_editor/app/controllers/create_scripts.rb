require 'nokogiri'


# Loop through all available plays and parse XML for each one
def createAllScripts()

    # List of lists that pairs all play names with their Folger's acronyms
    plays = [["MND", "a_midsummer_nights_dream"], ["AWW", 'alls_well_that_ends_well'], ["Ant", 'antony_and_cleopatra'], ["AYL", 'as_you_like_it'], ["Cor", 'coriolanus'], ["Cym", 'cymbeline'], 
        ["Ham", 'hamlet'], ["1H4", 'henry_iv_part_1'], ["2H4", 'henry_iv_part_2'], ["H5", 'henry_v'], ["1H6",'henry_vi_part_1'], ["2H6", 'henry_vi_part_2'],
        ["3H6", 'henry_vi_part_3'], ["H8", 'henry_viii'], ["JC", 'julius_caesar'],  ["Jn", 'king_john'], ["Lr", 'king_lear'], ["LLL", 'loves_labors_lost'],
        ["Mac", 'macbeth'], ["MM", 'measure_for_measure'], ["Ado", 'much_ado_about_nothing'], ["Oth", 'othello'], ["Per", 'pericles'], ["R2", 'richard_ii'], ["R3", 'richard_iii'], 
        ["Rom", 'romeo_and_juliet'], ["Shr", 'taming_of_the_shrew'], ["Err", 'the_comedy_of_errors'], ["MV", 'the_merchant_of_venice'], ["Wiv", 'the_merry_wives_of_windsor'],
        ["Tmp", 'the_tempest'], ["TGV", 'the_two_gentlemen_of_verona'], ["TNK", 'the_two_noble_kinsmen'], ["WT", 'the_winters_tale'],
        ["Tim", 'timon_of_athens'], ["Tit", 'titus_andronicus'], ["Tro", 'troilus_and_cressida'], ["TN", 'twelfth_night'], ["Ven", 'venus_and_adonis']]

    plays.each do |play|
        text = createScript(play[0], true)
        filename = '../../edited_' + play[1] + '.html'
        File.open(filename, "w") {|f| f.write(text)}
    end 
end

def createScript(title, flag)

    # If this was called from the command line or from the controller, 
    # the files for some reason need different paths
    if flag == true
        doctitle = "../../FolgerDigitalTexts_XML_Complete/" + title.to_s + ".xml"
    else 
        doctitle = "FolgerDigitalTexts_XML_Complete/" + title.to_s + ".xml"

    end

    doc = Nokogiri::XML(File.open(doctitle))

    
    htmlstring = ""

    # Create act and scene numbers to update
    currAct = 1
    currScene = 1
    currIndex = 1  

    # DISPLAY ACT NUMBER
    acts = doc.css('//div1')
    acts.each do |act|
        if Nokogiri::XML(act.to_s).css('head').first != nil
            actname = "Diva" + currAct.to_s
            actheadname = "a" + currAct.to_s
            actstring = '<div class="actDiv" id="' + actname + '"><button class="acthead" id="' + actheadname + '" data-cut="false" data-display="true">' + Nokogiri::XML(act.to_s).css("head").first.inner_text + '</button><br></b>'
            htmlstring << actstring
        end
        
        # DISPLAY SCENE NUMBER
        currAct = currAct + 1
        scenes = Nokogiri::XML(act.to_s).css('//div2')
        currScene = 1
        scenes.each do |scene|       
            if Nokogiri::XML(scene.to_s).css('head').first != nil
                scenename = "Divs" + currScene.to_s
                sceneheadname = "s" + currIndex.to_s 
                scenestring = '<div class="sceneDiv" id="'+ scenename + '"><button class="scenehead" id="' + sceneheadname + '" data-cut="false" data-display="true">' +  Nokogiri::XML(scene.to_s).css('head').first.inner_text + '</button><br>'
                htmlstring << scenestring
            end
            
            currScene = currScene + 1
            currIndex = currIndex + 1

            lines = Nokogiri::XML(scene.to_s).css('//sp')
            stages = Nokogiri::XML(scene.to_s).css('stage').to_a

            lines.each do |line|
            # DISPLAY STAGE DIRECTIONS
                # Get line id
                lineN = line.attr("xml:id").to_s.gsub("sp-","").to_i

                stages.each do |stage|
                    # Get stage direction id
                    stageN = stage.attr('xml:id').to_s.gsub("stg-","").to_i
                    # If there is a stage dir that comes before the line
                    if (stageN < lineN) and (stageN >= lineN-1.0)
                        # display stage direction
                        stagestring = '<br><button class="stage" data-cut="false" data-display="true">' + stage.inner_text + '</button> <br>'
                        htmlstring << stagestring
                        stages.delete(stage)
                    end
                end

                # Getting all the info needed for each line
                speaker = Nokogiri::XML(line.to_s).css('speaker')
                milestones = Nokogiri::XML(line.to_s).css('milestone')
                spwords = Nokogiri::XML(line.to_s).css('w','c','pc')

                # DISPLAY SPEAKER
                speakerstring = '<br><p class="speaker">' + speaker.inner_text + '</p><br>'
                htmlstring << speakerstring

                # DISPLAY LINES
                milestones.each do |ms|

                    msN = ms.attr("xml:id").to_s.gsub("ftln-","").to_f
                    stages.each do |stage|
                        # Get stage direction id
                        stageN = stage.attr('xml:id').to_s.gsub("stg-","").to_f
                        # If there is a stage dir inside speech
                        if (stageN <= msN) and (stageN >= msN-1.0)
                        # display stage direction
                            stagestring = '<button class="stage inside" data-cut="false" data-display="true">' + stage.inner_text + '</button> <br>'
                            htmlstring << stagestring
                            stages.delete(stage)
                        end
                    end

                    # get line number
                    lineNum = ms.attr("n").to_s.split(".")[2]
                    # get corresps per milestone in array
                    wordIDs = ms.attr("corresp").to_s.split(" ")
                    # remove #s
                    wordIDs = wordIDs.map { |w| w.gsub("#","")}
                    # Search spwords for corresponding w/c/pc
                    
                    # DISPLAY LINE NUMBER
                    if lineNum.to_i % 5 == 0
                        linenumstring = '<p class="lineNum">' + lineNum.to_s + '</p>'
                        htmlstring << linenumstring
                    end

                    wordIDs.each do |id|
                        spwords.each do |word|
                            if word.attr('xml:id').to_s == id
                            # DISPLAY EACH WORD
                            if (word.inner_text == ".") || (word.inner_text == ",") || (word.inner_text == "?") || (word.inner_text == "!") || (word.inner_text == ";") || (word.inner_text == ":")
                                wordstring = '<button class="punc" data-cut="false" data-display="true">' + word.inner_text + '</button> '
                                htmlstring << wordstring
                            else
                                if word.inner_text != "" && word.inner_text != " "
                                    wordstring = '<button class="word" data-cut="false" data-display="true">' + word.inner_text + '</button> '
                                    htmlstring << wordstring
                                end
                            end
                        end
                    end
                end

                # BREAK FOR NEW LINE
                htmlstring << '<br>'


                stages.each do |stage|
                    # Get stage direction id
                    stageN = stage.attr('xml:id').to_s.gsub("stg-","").to_f
                    # If there is a stage dir inside speech
                    if (stageN >= msN) and (stageN < msN+1.0)
                        # display stage direction
                        stagestring = '<button class="stage inside" data-cut="false" data-display="true">' + stage.inner_text + '</button> <br>'
                        htmlstring << stagestring
                        stages.delete(stage)
                    end
                end

            end
            end

            # Any last stage direction at the end of the section
            htmlstring << '<br>'
            stages.each do |stage|
                stagestring = '<button class="stage" data-cut="false" data-display="true">' + stage.inner_text + '</button> <br>'
                htmlstring << stagestring
                stages.delete(stage)
            end
        end

        htmlstring << '</div>'
        htmlstring << '<br>'
    end

    htmlstring << '</div>'

    return htmlstring

end


# Parsing command line arguments, usage: ruby create_scripts.rb all
all_flag = ARGV

if all_flag == 'all'
    print ('Creating all scripts')
    createAllScripts()
end
