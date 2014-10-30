# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ipaddress/ipaddress-0.8.0.ebuild,v 1.5 2014/10/30 13:55:54 mrueg Exp $

EAPI=4

# ruby20, ruby21 → fails tests
USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="A library designed to make manipulation of IPv4 and IPv6 addresses both powerful and simple"
HOMEPAGE="http://github.com/bluemonk/ipaddress"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

all_ruby_prepare() {
	# Fix deprecated rake task invocation.
	sed -i -e 's:rake/rdoctask:rdoc/task:' Rakefile || die
}
