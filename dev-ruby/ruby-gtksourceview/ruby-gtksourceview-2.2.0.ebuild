# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtksourceview/ruby-gtksourceview-2.2.0.ebuild,v 1.1 2014/03/17 14:59:34 naota Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_NAME="gtksourceview2"

inherit ruby-ng-gnome2

RUBY_S=ruby-gnome2-all-${PV}/gtksourceview2

DESCRIPTION="Ruby bindings for gtksourceview"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	x11-libs/gtksourceview:2.0"
DEPEND="${DEPEND}
	x11-libs/gtksourceview:2.0"

ruby_add_rdepend ">=dev-ruby/ruby-gtk2-${PV}"
