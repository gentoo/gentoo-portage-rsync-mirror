# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/arel/arel-4.0.0.ebuild,v 1.1 2013/10/07 08:16:32 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.markdown"

# Generating the gemspec from metadata causes a crash in jruby
RUBY_FAKEGEM_GEMSPEC="arel.gemspec"

inherit ruby-fakegem versionator

DESCRIPTION="Arel is a Relational Algebra for Ruby."
HOMEPAGE="http://github.com/rails/arel"
LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	test? (
		dev-ruby/test-unit:2
		virtual/ruby-minitest
	)"

all_ruby_prepare() {
	# Put the proper version number in the gemspec.
	sed -i -e "s/ s.version = \".*\"/ s.version = \"${PV}\"/" arel.gemspec || die
}

each_ruby_test() {
	ruby-ng_testrb-2 -Ilib test/test_*.rb
}
