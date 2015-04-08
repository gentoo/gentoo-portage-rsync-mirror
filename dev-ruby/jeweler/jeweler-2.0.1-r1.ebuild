# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jeweler/jeweler-2.0.1-r1.ebuild,v 1.4 2015/03/04 11:19:26 ago Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC="-Ilib yard"
RUBY_FAKEGEM_DOCDIR="doc"

# Tests and features also need the same set of dependencies present.
RUBY_FAKEGEM_TASK_TEST="-Ilib test"

RUBY_FAKEGEM_EXTRADOC="ChangeLog.markdown README.markdown"

RUBY_FAKEGEM_GEMSPEC="jeweler.gemspec"

inherit ruby-fakegem

DESCRIPTION="Rake tasks for managing gems and versioning and a generator for creating a new project"
HOMEPAGE="http://wiki.github.com/technicalpickles/jeweler"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/yard )
	test? ( dev-ruby/shoulda dev-ruby/rr dev-ruby/test_construct )"

ruby_add_rdepend "
	dev-ruby/rake
	>=dev-ruby/git-1.2.5
	>=dev-ruby/nokogiri-1.5.10
	dev-ruby/github_api
	>=dev-ruby/highline-1.6.15
	>=dev-ruby/bundler-1.0
	dev-ruby/rdoc
	dev-ruby/builder
"

all_ruby_prepare() {
	# Remove bundler support.
	rm Gemfile || die
	sed -i -e '/bundler/d' -e '/Bundler.setup/d' Rakefile test/test_helper.rb features/support/env.rb || die

	sed -i -e '/coverall/I s:^:#:' test/test_helper.rb || die

	# Avoid a test that only passes in the git repository.
	sed -i -e '/find the base repo/,/^  end/ s:^:#:' test/test_jeweler.rb || die

	# Use a non-deprecated version of construct
	sed -i -e 's/construct/test_construct/' -e 's/Construct/TestConstruct/' test/test_helper.rb || die
}
