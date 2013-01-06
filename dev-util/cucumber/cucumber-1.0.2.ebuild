# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cucumber/cucumber-1.0.2.ebuild,v 1.2 2012/06/12 11:51:05 iksaif Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

# Documentation task depends on sdoc which we currently don't have.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="none"
RUBY_FAKEGEM_EXTRADOC="History.md README.md"

RUBY_FAKEGEM_GEMSPEC="cucumber.gemspec"

inherit ruby-fakegem

DESCRIPTION="Executable feature scenarios"
HOMEPAGE="https://github.com/cucumber/cucumber/wikis"
LICENSE="Ruby"

KEYWORDS="~amd64"
SLOT="0"
IUSE="examples"

ruby_add_bdepend "
	test? (
		>=dev-ruby/rspec-2.6.0
		>=dev-ruby/nokogiri-1.4.4
		>=dev-ruby/prawn-layout-0.8.4
		>=dev-ruby/spork-0.8.4-r1
		>=dev-ruby/syntax-1.0.0
		>=dev-util/aruba-0.4.2
	)"
# simplecov 0.4.1?

ruby_add_rdepend "
	>=dev-ruby/builder-2.1.2
	>=dev-ruby/diff-lcs-1.1.2
	>=dev-ruby/gherkin-2.4.5
	>=dev-ruby/json-1.4.6
	>=dev-ruby/term-ansicolor-1.0.5
"

all_ruby_prepare() {
	# Remove Bundler-related things.
	sed -i -e '/[Bb]undler/d' Rakefile spec/spec_helper.rb || die
	rm Gemfile || die

	# Make sure spork is run in the right interpreter
	sed -i -e 's/#{Spork::BINARY}/-S #{Spork::BINARY}/' features/support/env.rb || die
}

each_ruby_test() {
	${RUBY} -Ilib -S rspec spec || die "Specs failed"
	${RUBY} -Ilib bin/cucumber features || die "Features failed"
}

all_ruby_install() {
	all_fakegem_install

	if use examples; then
		cp -pPR examples "${D}/usr/share/doc/${PF}" || die "Failed installing example files."
	fi
}
