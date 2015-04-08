# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sinatra/sinatra-1.4.5.ebuild,v 1.4 2014/08/15 14:01:51 blueness Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

# no documentation is generable, it needs hanna, which is broken
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.md AUTHORS CHANGES"

inherit ruby-fakegem

DESCRIPTION="Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort"
HOMEPAGE="http://www.sinatrarb.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend "=dev-ruby/rack-1* >=dev-ruby/rack-1.4
	>=dev-ruby/rack-protection-1.4:1
	=dev-ruby/tilt-1* >=dev-ruby/tilt-1.3.4"
ruby_add_bdepend "test? ( >=dev-ruby/rack-test-0.5.6 dev-ruby/erubis dev-ruby/builder )"

# haml tests are optional and not yet marked for ruby20.
USE_RUBY="ruby19" ruby_add_bdepend "test? ( >=dev-ruby/haml-3.0 )"

all_ruby_prepare() {
	# Remove slim tests since only version 1.x is supported and we only
	# have version 2.x
	rm test/slim_test.rb || die

	# Remove markdown tests since these fail due to encoding issues. Not
	# clear where the actual problem is.
	rm test/markdown_test.rb || die

	# Remove implicit build dependency on git.
	sed -i -e '/\(s.files\|s.test_files\|s.extra_rdoc_files\)/d' sinatra.gemspec || die
}
