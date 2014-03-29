# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/memoizable/memoizable-0.4.2.ebuild,v 1.2 2014/03/29 10:22:23 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Memoize method return values"
HOMEPAGE="https://github.com/dkubb/memoizable"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/thread_safe-0.3.1:0"

all_ruby_prepare() {
	sed -i -e "/simplecov/,/^end$/d" spec/spec_helper.rb || die
}
