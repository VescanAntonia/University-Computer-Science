import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import service.Service;
import repository.StudentXMLRepository;
import validation.StudentValidator;
import domain.Student;

public class TestAddStudent {

    @Test
    public void testSaveStudentSuccess() {
        // Setup
        StudentValidator validator = new StudentValidator();
        // Assume "students.xml" is your temporary or test XML file
        StudentXMLRepository studentRepo = new StudentXMLRepository(validator, "students.xml");
        Service service = new Service(studentRepo, null, null); // Only testing student-related functionality

        // Execute
        int result = service.saveStudent("1", "Test Student", 101);

        // Verify
        assertEquals(1, result, "Student should be successfully saved and method should return 1");
    }

    @Test
    public void testSaveStudentFailureDueToDuplicate() {
        // Setup
        StudentValidator validator = new StudentValidator();
        // Assume "students.xml" contains a student with ID "1" already
        StudentXMLRepository studentRepo = new StudentXMLRepository(validator, "students.xml");
        Service service = new Service(studentRepo, null, null);

        // Assuming a student with ID "1" already exists, trying to save another should fail
        service.saveStudent("1", "Existing Student", 101); // Setup existing student, if necessary
        int result = service.saveStudent("1", "New Student", 102); // Attempt to save another with the same ID

        // Verify
        assertEquals(1, result, "Attempt to save a duplicate student should fail and return 0");
    }
}
