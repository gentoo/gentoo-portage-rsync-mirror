# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-rsvg/ruby-rsvg-2.2.3.ebuild,v 1.2 2015/03/25 20:03:09 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_NAME=rsvg2

inherit ruby-ng-gnome2

RUBY_S=ruby-gnome2-all-${PV}/rsvg2

DESCRIPTION="Ruby bindings for librsvg"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cairo"

RDEPEND="${RDEPEND}
	>=gnome-base/librsvg-2.8"
DEPEND="${DEPEND}
	>=gnome-base/librsvg-2.8"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gdkpixbuf2-${PV}
	cairo? ( dev-ruby/rcairo )"
