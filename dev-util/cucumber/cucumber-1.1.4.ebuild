# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cucumber/cucumber-1.1.4.ebuild,v 1.9 2012/10/28 18:18:57 armin76 Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18"

# Documentation task depends on sdoc which we currently don't have.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="none"
RUBY_FAKEGEM_EXTRADOC="History.md README.md"

RUBY_FAKEGEM_GEMSPEC="cucumber.gemspec"

inherit ruby-fakegem

DESCRIPTION="Executable feature scenarios"
HOMEPAGE="https://github.com/cucumber/cucumber/wikis"
LICENSE="Ruby"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE="examples"

ruby_add_bdepend "
	test? (
		>=dev-ruby/rspec-2.6.0
		>=dev-ruby/nokogiri-1.5.0
		>=dev-ruby/prawn-layout-0.8.4
		>=dev-ruby/spork-0.8.4-r1
		>=dev-ruby/syntax-1.0.0
		>=dev-util/aruba-0.4.6
	)"

ruby_add_rdepend "
	>=dev-ruby/builder-2.1.2
	>=dev-ruby/diff-lcs-1.1.2
	>=dev-ruby/gherkin-2.6.7:0
	>=dev-ruby/json-1.4.6
	>=dev-ruby/term-ansicolor-1.0.6
"

all_ruby_prepare() {
	# Remove Bundler-related things.
	sed -i -e '/[Bb]undler/d' Rakefile spec/spec_helper.rb || die
	rm Gemfile || die

	# Make sure spork is run in the right interpreter
	sed -i -e 's/#{Spork::BINARY}/-S #{Spork::BINARY}/' features/support/env.rb || die

	# Skip failing tests due to hash ordering
	sed -i -e '/when a specified profile does not exist/,/end/ s:^:#:' spec/cucumber/cli/configuration_spec.rb || die
	sed -i -e '/should allow Array of Hash/,/end/ s:^:#:' spec/cucumber/ast/table_spec.rb || die
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
