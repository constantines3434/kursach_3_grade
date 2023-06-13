using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;
using System.Data;

namespace WpfApp1
{
    public class ExaminerItem
    {
        public int Id { get; set; }
        public string Fio { get; set; }

        public ExaminerItem(int id, string fio)
        {
            this.Id = id;
            this.Fio = fio;
        }
    }


    public class Teach
    {
        public int Id { get; set; }
        public string Fio { get; set; }

        public Teach(int id, string fio)
        {
            this.Id = id;
            this.Fio = fio;
        }
    }
    public partial class Choice_admin : Page
    {
        private string roleUser;

        private List<Tickets> tick;

        public Choice_admin(string role)
        {
            InitializeComponent();
            InitializationSpeciality();
            InitializationKurs();
            InitializationSemester();
            InitializationProtocols();
            InitializationChairman();
            var rng = new Random();
            tick = RandomTicketGenerator.GetContext().Tickets.ToList();
            tick = tick.OrderBy(x => rng.Next()).ToList();
            roleUser = role;
        }
        private string FindSpecialityId()
        {
            return ((Speciality)Spec.SelectedItem).code_speciality;
        }
        /// <summary>
        /// получение id специальности 
        /// </summary>
        private string FindSpecId(string code)
        {
            string id =
    (from i in RandomTicketGenerator.GetContext().Speciality.ToList()
     where i.code_speciality == code//FindSpecialityId()
     select i.code_speciality).First();
            return id;
        }
        /// <summary>
        /// заполнение ComboBox Специальности
        /// </summary>
        private void InitializationSpeciality()
        {

            IEnumerable<Speciality> Speciality_list = from i in RandomTicketGenerator.GetContext().Speciality.ToList()
                                                      select i;
            DataContext = Speciality_list;
            Spec.ItemsSource = Speciality_list;
            Spec.SelectedValuePath = "";
            Spec.DisplayMemberPath = "name_of_speciality";
            Spec.SelectedIndex = 0;
        }
        /// <summary>
        /// получение id Курса
        /// </summary>
        private int GetKursId()
        {
            int id =
    (from i in RandomTicketGenerator.GetContext().Kurs.ToList()
     where i.nom_kurs == Convert.ToInt32(Kurs.Text)
     select i.nom_kurs).First();
            return id;
        }
        private int GetKurs()
        {
            return ((Kurs)Kurs.SelectedItem).nom_kurs;
        }

        private void InitializationKurs()
        {
            IEnumerable<Kurs> Kurs_list = from i in RandomTicketGenerator.GetContext().Kurs.ToList()
                                          select i;
            DataContext = Kurs_list;
            Kurs.ItemsSource = Kurs_list;
            Kurs.SelectedValuePath = "";
            Kurs.DisplayMemberPath = "nom_kurs";
            Kurs.SelectedIndex = 0;
        }
        /// <summary>
        /// получение id Семестров
        /// </summary>
        private int GetSemesterId()
        {
            int id =
    (from i in RandomTicketGenerator.GetContext().Semesters.ToList()
     where i.nom_semester == Convert.ToInt32(Semester.Text)
     select i.nom_semester).First();
            return id;
        }
        private DateTime GetSemDate()
        {
            return ((Semesters)Semester.SelectedItem).academic_year.Value;
        }

        private string GetSemYearString()
        {
            return GetSemDate().ToString("yyyy");
        }
        /// <summary>
        /// заполнение ComboBox Специальности
        /// </summary>
        private void InitializationSemester()
        {
            IEnumerable<Semesters> Semesters_list = from i in RandomTicketGenerator.GetContext().Semesters.ToList()
                                                    select i;
            DataContext = Semesters_list;
            Semester.ItemsSource = Semesters_list;
            Semester.SelectedValuePath = "";
            Semester.DisplayMemberPath = "nom_semester";
            Semester.SelectedIndex = 0;
        }
        /// <summary>
        /// получение id протокола
        /// </summary>
        private int GetProtocolsId()
        {
            int id =
    (from i in RandomTicketGenerator.GetContext().Protocols.ToList()
     where i.nom_protocol == Convert.ToInt32(Protocol.Text)
     select i.nom_protocol).First();
            return id;
        }
        /// <summary>
        /// заполнение ComboBox Протоколов
        /// </summary>
        private void InitializationProtocols()
        {
            IEnumerable<Protocols> Protocols_list = from i in RandomTicketGenerator.GetContext().Protocols.ToList()
                                                    select i;
            DataContext = Protocols_list;
            Protocol.ItemsSource = Protocols_list;
            Protocol.SelectedValuePath = "";
            Protocol.DisplayMemberPath = "nom_protocol";
            Protocol.SelectedIndex = 0;
        }
        private DateTime GetProtDate()
        {
            return ((Protocols)Protocol.SelectedItem).date_protocol.Value;
        }
        private string GetProtDateString()
        {
            return GetProtDate().ToString("dd.MM.yyyy");
        }
        private void InitializationChairman()
        {
            IEnumerable<ExaminerItem> Chairman_list = from i in RandomTicketGenerator.GetContext().Chairman_pck.ToList()
                                                      let fio = i.surname + " " + i.name_[0] + "." + i.patronymic[0] + "."
                                                      select new ExaminerItem(i.id_chairman_pck, fio);
            DataContext = Chairman_list;
            Chairman.ItemsSource = Chairman_list;
            Chairman.DisplayMemberPath = "Fio";
            Chairman.SelectedIndex = 0;
        }
        List<Questions> Questions_list { get; set; }
        /// <summary>
        /// Инициализация Вопросов
        /// </summary>
        private void Initialize_questions()
        {
            IEnumerable<Questions> Quest_list = (from i in RandomTicketGenerator.GetContext().Questions.ToList()
                                                 where i.id_discipline == FindDisciplineId(FindSpecId(FindSpecialityId()))
                                                 select i);
            var rng = new Random();
            Questions_list = Quest_list.OrderBy(x => rng.Next()).ToList();
        }

        /// <summary>
        /// получение id Председателя
        /// </summary>
        private int GetChairmanId()
        {
            return ((ExaminerItem)Chairman.SelectedItem).Id;
        }

        /// <summary>
        /// получение id учителя
        /// </summary>
        private int FindTeacher()
        {
            return ((Teach)Teacher.SelectedItem).Id;
        }
        /// <summary>
        /// получение id комплекта билетов
        /// </summary>
        private int FindKomplectId(int kursId, int semesterId, int protocolId, int chairmanId, int teacherId)
        {
            int id = 
    (int)(from i in RandomTicketGenerator.GetContext().Komplect_tickets.ToList()
          where i.nom_kurs == kursId//GetKursId() //+
          && i.nom_semester == semesterId//GetSemesterId() //+
          && i.nom_protocol == protocolId//GetProtocolsId() //+
                  && i.id_chairman_pck == GetChairmanId() //+
          && i.id_teacher == FindTeacher() //6, а нужен 2
          select i.nom_komplect).First();
            return id;
        }
        /// <summary>
        /// получение id билета
        /// </summary>
        private int NextTicketId(int komplectId)
        {
            int res = (from i in tick.ToList()
                       where i.nom_komplect == komplectId
                       select i.id_ticket).First();
            tick.RemoveAll((ticket) => ticket.id_ticket == res);
            return res;
        }
        private IEnumerable<string> FindQuestions(int tickId) //NextTicketid
        {
            var tickets = (from i in RandomTicketGenerator.GetContext().Tickets.ToList()
                           where i.id_ticket == tickId
                           select i).First();

            var questions = (from quest in RandomTicketGenerator.GetContext().Questions.ToList()
                             where
                             (quest.id_question == tickets.id_quest1
                             || quest.id_question == tickets.id_quest2
                             || quest.id_question == tickets.id_quest3)
                             && quest.id_discipline == FindDisciplineId(FindSpecId(FindSpecialityId()))
                             select quest.question);
            return questions;
        }
        private int FindDisciplineId(string specfind) //+
        {
            int id =
            (from i in RandomTicketGenerator.GetContext().Disciplines.ToList()
             where i.code_speciality == specfind //GetSpecialityId()
             select i.id_discipline).First();
            return id;
        }

        private int FindTeacherId()
        {
            int id =
            (from i in RandomTicketGenerator.GetContext().Teacher.ToList()
             where i.id_discipline == FindDisciplineId(FindSpecId(FindSpecialityId())) //discId//GetDisciplineId()
             && i.id_teacher == FindTeacher()
             select i.id_teacher).First();
            return id;
        }
        private void But_Confirmation_Click(object sender, RoutedEventArgs e)
        {

            IEnumerable<Disciplines> Disc_list = from i in RandomTicketGenerator.GetContext().Disciplines.ToList()
                                                 where i.code_speciality == FindSpecId(FindSpecialityId())
                                                 && i.id_discipline == FindDisciplineId(FindSpecId(FindSpecialityId())) //2//FindDisciplineId(FindSpecialityId())
                                                 select i;
            DataContext = Disc_list;
            Disca.ItemsSource = Disc_list;
            Disca.SelectedValuePath = "";
            Disca.DisplayMemberPath = "name_discipline";
            Disca.SelectedIndex = 0;

            IEnumerable<Teach> Teacher_list = from i in RandomTicketGenerator.GetContext().Teacher.ToList()
                                              where i.id_discipline == FindDisciplineId(FindSpecId(FindSpecialityId()))//2//FindDiscipline()
                                              let fio = i.surname + " " + i.name_[0] + "." + i.patronymic[0] + "."
                                              select new Teach(i.id_teacher, fio);
            DataContext = Teacher_list;
            Teacher.ItemsSource = Teacher_list;
            Teacher.DisplayMemberPath = "Fio";
            Teacher.SelectedIndex = 0;
        }

        private void But_Click_Form_Ticket(object sender, RoutedEventArgs e)
        {
            Initialize_questions();

            string disca_content = Disca.Text;
            var helper = new WordHelper("Ex_Ticket_Prac.docx");
            string count_tickets = count_of_tickets.Text;
            string teacher_content = Teacher.Text;
            string Chairman_pck_content = Chairman.Text;
            string kurs_content = Kurs.Text;
            string semester_content = Semester.Text;
            string speciality_content = Spec.Text;
            string protocol_content = Protocol.Text;
            string protocol_date_content = GetProtDateString();
            string sem_year_content = GetSemYearString();
            int nom_ticket = 1;
            int t;
            if (int.TryParse(count_tickets, out t))
            {
                if (t < 1)
                {
                    MessageBox.Show("Число билетов должно быть >= 1");
                    return;
                }
            }
            else
            {
                MessageBox.Show("Неверный формат");
                return;
            }
            try
            {
                for (int i = 0; i < Convert.ToInt32(count_tickets); i++)
                {
                    //тут подумай
                    var ticket = new List<string>(FindQuestions(NextTicketId(FindKomplectId(GetKursId(), GetSemesterId(), GetProtocolsId(),
                       GetChairmanId(), FindTeacherId()))));
                    string quest1 = ticket[0];
                    string quest2 = ticket[1];
                    string quest3 = ticket[2];
                    MessageBox.Show("Формирование билета");
                    var Items = new Dictionary<string, string>
                         {
                             {"<DISC>", disca_content},
                             {"<PCK>",  Chairman_pck_content},
                             {"<PREP>", teacher_content},
                             {"<KURS>", kurs_content},
                             {"<SEM>", semester_content},
                             {"<SPEC>", speciality_content},
                             {"<NOMPROT>", protocol_content},
                             {"<DATEPROT>", protocol_date_content},
                             {"<YEARSEM> ", sem_year_content},
                             {"<NOMTICK>", nom_ticket.ToString()},
                             {"<TEO1>", quest1},
                             {"<TEO2>", quest2},
                             {"<PRAC1>", quest3},
                         };
                    helper.Process(Items, disca_content, nom_ticket);
                    MessageBox.Show($"Билет {disca_content} №{nom_ticket} сформирован");
                    nom_ticket++;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Билеты закончились");
            }
        }
        private void But_Click_Viewing_Table_Data(object sender, RoutedEventArgs e)
        {
            if (roleUser == "Admin")
            {
                NavigationService.Navigate(new ViewingTableData_admin(roleUser));
            }
            else
            {
                MessageBox.Show("Только администратор может редактировать таблицы");
            }
        }
        private void But_Auto(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Authorization());
        }
    }
}

