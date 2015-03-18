import java.io.File;

import org.blinkenlights.jid3.ID3Exception;
import org.blinkenlights.jid3.MP3File;
import org.blinkenlights.jid3.MediaFile;
import org.blinkenlights.jid3.v2.ID3V2_3_0Tag;
import org.junit.Test;

public class Mp3Test {

    @Test
    public void testName() throws Exception {

	File diretorio = new File("C:/Users/lotero/Music/Iron Maiden/2010 - The Final Frontier");

	for (File file : diretorio.listFiles()) {
	    if (file.getName().endsWith(".mp3")) {
		editTag(file);
	    }
	}
    }

    private void editTag(File oSourceFile) throws ID3Exception {
	MediaFile oMediaFile = new MP3File(oSourceFile);

	ID3V2_3_0Tag tag = new ID3V2_3_0Tag();
	tag.setAlbum("The Final Frontier");
	tag.setArtist("Iron Maiden");
	tag.setGenre("Heavy Metal");
	tag.setYear(2010);
	tag.setTitle(oSourceFile.getName().substring(oSourceFile.getName().indexOf("-") + 1,oSourceFile.getName().length() - 4 ).trim());

	oMediaFile.setID3Tag(tag);

	oMediaFile.sync();
    }

}
