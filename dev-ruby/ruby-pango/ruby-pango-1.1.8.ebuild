# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-pango/ruby-pango-1.1.8.ebuild,v 1.4 2013/08/17 10:37:26 ago Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Pango bindings"
KEYWORDS="amd64 ppc x86"
IUSE=""
DEPEND="${DEPEND}
	>=x11-libs/pango-1.2.1
	>=dev-ruby/rcairo-1.2.0"
RDEPEND="${RDEPEND}
	>=x11-libs/pango-1.2.1
	>=dev-ruby/rcairo-1.2.0"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}"
