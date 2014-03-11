# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-goocanvas/ruby-goocanvas-1.2.6.ebuild,v 1.2 2014/03/11 01:42:30 mrueg Exp $

EAPI=4
USE_RUBY="ruby18 ruby19"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby binding of GooCanvas"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	x11-libs/goocanvas:0"
DEPEND="${DEPEND}
	x11-libs/goocanvas:0"

ruby_add_bdepend "dev-ruby/pkg-config
	dev-ruby/rcairo"

ruby_add_rdepend ">=dev-ruby/ruby-gtk2-${PV}"
