# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/connection_pool/connection_pool-1.1.0.ebuild,v 1.1 2013/11/25 01:55:17 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="rake"
RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="Changes.md README.md"

inherit ruby-fakegem

DESCRIPTION="Generic connection pooling for Ruby"
HOMEPAGE="https://github.com/mperham/connection_pool"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? ( >=dev-ruby/minitest-5 )"

all_ruby_prepare() {
	# Fix test
	sed -i -e "2s/.*/require 'minitest'/" test/helper.rb || die "sed failed"
}
