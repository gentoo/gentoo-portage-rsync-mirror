# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gherkin/gherkin-2.3.10.ebuild,v 1.2 2011/06/02 09:52:49 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC="-Ilib -rgherkin/version -f tasks/rdoc.rake rdoc"
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Fast Gherkin lexer and parser based on Ragel."
HOMEPAGE="http://wiki.github.com/aslakhellesoy/cucumber/gherkin"
LICENSE="MIT"
SRC_URI="https://github.com/cucumber/gherkin/tarball/v${PV} -> ${P}.tgz"

KEYWORDS="~amd64"
SLOT="0"
IUSE="doc test"

DEPEND="${DEPEND} dev-util/ragel"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/cucumber-gherkin-*"

ruby_add_bdepend "
	dev-ruby/rake-compiler
	test? (
		>=dev-ruby/awesome_print-0.4.0
		>=dev-ruby/builder-2.1.2
		>=dev-util/cucumber-0.10.0
		>=dev-ruby/rspec-2.6.0
		>=dev-ruby/term-ansicolor-1.0.5
	)"

ruby_add_rdepend ">=dev-ruby/json-1.4.6"

all_ruby_prepare() {
	epatch "${FILESDIR}/${P}-no-werror.patch"

	# Remove Bundler-related things.
	sed -i -e '/[Bb]undler/d' Rakefile spec/spec_helper.rb features/support/env.rb || die
	rm Gemfile || die

	# Don't use compile dependencies to avoid building again for specs.
	sed -i -e '/:compile/d' Rakefile

	# Remove feature that depends on direct access to the cucumber
	# source. We could probably set this up by downloading the source
	# and unpacking it, but skipping this now in the interest of time.
	rm features/pretty_formatter.feature || die

	# We need to remove this tasks during bootstrapping since it tries
	# to load cucumber already but we can be sure it isn't installed
	# yet.
	if ! use test ; then
		rm tasks/cucumber.rake || die "Unable to remove cucumber tasks."
	fi
}

each_ruby_compile() {
	${RUBY} -I lib -S rake -rrake/clean -f tasks/compile.rake compile || die
}

each_ruby_test() {
	${RUBY} -S rake spec || die "Specs failed"
	CUCUMBER_HOME="${HOME}" ${RUBY} -S rake cucumber || die "Cucumber features failed"
}
