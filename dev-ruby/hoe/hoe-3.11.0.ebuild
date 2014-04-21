# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hoe/hoe-3.11.0.ebuild,v 1.1 2014/04/21 05:58:07 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt"

RUBY_FAKEGEM_EXTRAINSTALL="template"

inherit ruby-fakegem

DESCRIPTION="Hoe extends rake to provide full project automation."
HOMEPAGE="http://seattlerb.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "test? ( >=dev-ruby/minitest-5.3:5 )"

ruby_add_rdepend ">=dev-ruby/rake-0.8.7 >=dev-ruby/rdoc-4.0"

all_ruby_prepare() {
	# Skip isolation
	sed -i -e '/isolate/ s:^:#:' Rakefile || die

	# Skip test depending on specifics of gem command name
	sed -i -e '/test_nosudo/,/^  end/ s:^:#:' test/test_hoe.rb || die

	# Gem.bin_wrapper does not work as expected on Gentoo.
	sed -i -e 's/Gem.bin_wrapper//' lib/hoe/rcov.rb lib/hoe/publish.rb test/test_hoe_publish.rb || die
}

all_ruby_compile() {
	all_fakegem_compile

	rdoc --title "seattlerb's hoe-3.5.1 Documentation" -o doc --main README.txt lib History.txt Manifest.txt README.txt || die
}
