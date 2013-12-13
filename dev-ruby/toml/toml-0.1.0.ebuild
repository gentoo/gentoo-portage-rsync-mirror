# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/toml/toml-0.1.0.ebuild,v 1.1 2013/12/13 03:31:29 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="A sane configuration format"
HOMEPAGE="https://github.com/jm/toml"

IUSE="test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_bdepend "test? ( dev-ruby/minitest
		dev-ruby/multi_json )"

ruby_add_rdepend "dev-ruby/parslet"

all_ruby_prepare() {
	sed -i -e "s/, '~> 1.7.8'//" Gemfile || die
	sed -i -e "/simplecov/d" -e "/[Bb]undle/d" Rakefile Gemfile || die
	sed -i -e "/bundler/d" test/test_*.rb || die
}

each_ruby_test() {
	for i in test/test_*
	do
		${RUBY} -Ilib:test ${i} || die
	done
}
