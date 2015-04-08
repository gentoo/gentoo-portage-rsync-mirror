# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/configliere/configliere-0.4.22.ebuild,v 1.3 2014/11/03 15:09:09 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.textile README.textile FEATURES.txt"

inherit ruby-fakegem

DESCRIPTION="Settings manager for Ruby scripts"
HOMEPAGE="https://github.com/infochimps-labs/configliere"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/highline-1.5.2
	>=dev-ruby/multi_json-1.1"

all_ruby_prepare() {
	rm Gemfile* || die
	sed -i -e "/bundler/d" spec/spec_helper.rb || die
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r examples
}
