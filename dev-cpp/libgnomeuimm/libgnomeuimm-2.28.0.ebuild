# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomeuimm/libgnomeuimm-2.28.0.ebuild,v 1.8 2012/05/04 03:44:58 jdhore Exp $

inherit gnome2 eutils

DESCRIPTION="C++ bindings for libgnomeui"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2.7.1
	>=dev-cpp/libgnomemm-2.16.0
	>=dev-cpp/libgnomecanvasmm-2.6
	>=dev-cpp/gconfmm-2.6
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/gnome-vfsmm-2.16"

DEPEND="virtual/pkgconfig
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS INSTALL TODO"
