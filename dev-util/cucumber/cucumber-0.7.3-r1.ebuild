# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cucumber/cucumber-0.7.3-r1.ebuild,v 1.9 2012/10/28 17:24:11 armin76 Exp $

EAPI=3
USE_RUBY="ruby18 ree18"

# Documentation task depends on sdoc which we currently don't have.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="spec cucumber"
RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Executable feature scenarios"
HOMEPAGE="https://github.com/cucumber/cucumber/wikis"
LICENSE="Ruby"

KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE="examples"

ruby_add_bdepend test ">=dev-ruby/rspec-1.3.0 >=dev-ruby/nokogiri-1.4.1"

ruby_add_rdepend "
	>=dev-ruby/builder-2.1.2
	>=dev-ruby/diff-lcs-1.1.2
	>=dev-ruby/gherkin-1.0.27
	<dev-ruby/gherkin-2.0.0
	>=dev-ruby/json-1.2.4
	>=dev-ruby/term-ansicolor-1.0.4
"

all_ruby_prepare() {
	# Remove features checking for optional dependencies that we currently
	# don't have in our tree.
	rm -f features/drb_server_integration.feature features/cucumber_cli.feature || die "Unable to remove unsupported features."

	# Remove rspec 2.x support since it is based on a very early beta
	# and no longer compatible.
	epatch "${FILESDIR}/${P}-remove-rspec2.patch"
}

each_ruby_install() {
	each_fakegem_install

	ruby_fakegem_doins VERSION.yml
}

all_ruby_install() {
	all_fakegem_install

	if use examples; then
		cp -pPR examples "${ED}/usr/share/doc/${PF}" || die "Failed installing example files."
	fi
}

pkg_postinst() {
	ewarn "Cucumber 0.7.x has minor parsing incompatibilities. Check the upgrade guide"
	ewarn "for details: http://wiki.github.com/aslakhellesoy/cucumber/upgrading"
}
