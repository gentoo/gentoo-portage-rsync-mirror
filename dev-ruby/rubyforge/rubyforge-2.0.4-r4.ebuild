# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubyforge/rubyforge-2.0.4-r4.ebuild,v 1.2 2014/06/17 10:00:03 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Simplistic script which automates a limited set of rubyforge operations"
HOMEPAGE="http://codeforpeople.rubyforge.org/rubyforge/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend '>=dev-ruby/json-1.1.7'

ruby_add_bdepend "
	doc? ( >=dev-ruby/hoe-2.13 )
	test? (
		virtual/ruby-ssl
		>=dev-ruby/hoe-2.13
		dev-ruby/test-unit:2
	)"

all_ruby_prepare() {
	sed -i 's/json_pure/json/' "${WORKDIR}"/all/metadata || die "Unable to fix metadata."

	# Remove specifications incompatible with newer hoe versions.
	sed -i -e '/rubyforge_name/ s:^:#:' Rakefile || die

	# Require new enough test-unit for newer minitest
	sed -i -e '1igem "test-unit"' test/test_*.rb || die
}
