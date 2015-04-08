# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gio2/ruby-gio2-2.2.3.ebuild,v 1.2 2015/03/25 16:29:50 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby binding of GooCanvas"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND+="dev-libs/gobject-introspection"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}"
