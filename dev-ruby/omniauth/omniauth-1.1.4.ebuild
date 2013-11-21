# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/omniauth/omniauth-1.1.4.ebuild,v 1.1 2013/11/20 23:04:03 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="A generalized Rack framework for multiple-provider authentication"
HOMEPAGE="https://github.com/intridea/omniauth"
LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rack-test )"
ruby_add_rdepend "dev-ruby/hashie"

all_ruby_prepare() {
	sed -i -e '/simplecov/,+7d' spec/helper.rb || die
}
