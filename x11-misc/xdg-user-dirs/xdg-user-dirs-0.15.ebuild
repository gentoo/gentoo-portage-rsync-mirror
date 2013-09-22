# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdg-user-dirs/xdg-user-dirs-0.15.ebuild,v 1.2 2013/09/22 10:11:37 ago Exp $

EAPI=5

DESCRIPTION="A tool to help manage 'well known' user directories"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/xdg-user-dirs"
SRC_URI="http://user-dirs.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="gtk"

RDEPEND=""
# libxslt is mandatory because 0.15 tarball is broken, re:
# http://bugs.freedesktop.org/show_bug.cgi?id=66251
DEPEND="dev-libs/libxslt
	sys-devel/gettext"
PDEPEND="gtk? ( x11-misc/xdg-user-dirs-gtk )"

DOCS=( AUTHORS ChangeLog NEWS )
