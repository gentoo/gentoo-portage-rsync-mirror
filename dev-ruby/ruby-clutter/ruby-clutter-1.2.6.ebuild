# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-clutter/ruby-clutter-1.2.6.ebuild,v 1.2 2013/05/10 13:49:17 naota Exp $

EAPI=4
USE_RUBY="ruby19"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Clutter bindings"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="test"

RUBY_S=ruby-gnome2-all-${PV}/clutter

DEPEND="${DEPEND} media-libs/clutter"
RDEPEND="${RDEPEND} media-libs/clutter"

ruby_add_bdepend ">=dev-ruby/ruby-glib2-${PV}"
ruby_add_rdepend ">=dev-ruby/ruby-cairo-gobject-${PV}
	>=dev-ruby/ruby-gobject-introspection-${PV}"

each_ruby_configure() {
	:
}

each_ruby_compile() {
	:
}

each_ruby_install() {
	each_fakegem_install
}
