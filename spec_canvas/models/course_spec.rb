require File.expand_path(File.dirname(__FILE__) + '/../../../../../spec/spec_helper')

describe Course do
  describe "#recache_grade_distribution" do
    before :each do
      @course = course_model
      @enrollment = student_in_course
      @enrollment.workflow_state = 'active'
      @enrollment.computed_current_score = 12
      @enrollment.save!
    end

    it "should create the distribution row if not there yet" do
      @course.cached_grade_distribution.destroy
      @course.reload.recache_grade_distribution
      @course.reload.cached_grade_distribution.should_not be_nil
    end

    it "should update the existing distribution row if any" do
      @course.recache_grade_distribution
      existing = @course.cached_grade_distribution
      existing.s11.should == 0
      existing.s12.should == 1

      @enrollment.computed_current_score = 11
      @enrollment.save!

      @course.reload.recache_grade_distribution
      @course.cached_grade_distribution.should == existing
      existing.reload

      existing.s11.should == 1
      existing.s12.should == 0
    end
  end
end