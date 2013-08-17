# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-vte/ruby-vte-1.1.8.ebuild,v 1.4 2013/08/17 10:37:56 ago Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby vte bindings"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=x11-libs/vte-0.12.1:0"
DEPEND="${DEPEND}
	>=x11-libs/vte-0.12.1:0"

ruby_add_rdepend ">=dev-ruby/ruby-gtk2-${PV}"
