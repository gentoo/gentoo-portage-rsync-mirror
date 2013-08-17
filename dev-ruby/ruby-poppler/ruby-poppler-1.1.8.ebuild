# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-poppler/ruby-poppler-1.1.8.ebuild,v 1.4 2013/08/17 10:37:46 ago Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby poppler-glib bindings"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="${RDEPEND}
	app-text/poppler[cairo]"
DEPEND="${DEPEND}
	app-text/poppler[cairo]"

ruby_add_rdepend "dev-ruby/ruby-gdkpixbuf2
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"
