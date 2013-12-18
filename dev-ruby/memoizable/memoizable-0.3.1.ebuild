# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/memoizable/memoizable-0.3.1.ebuild,v 1.1 2013/12/18 12:54:14 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="Memoize method return values"
HOMEPAGE="https://github.com/dkubb/memoizable"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/thread_safe"

all_ruby_prepare() {
	sed -i -e "/simplecov/,/^end$/d" spec/spec_helper.rb || die
}
