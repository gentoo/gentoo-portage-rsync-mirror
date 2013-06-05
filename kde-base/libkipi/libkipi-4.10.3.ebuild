# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkipi/libkipi-4.10.3.ebuild,v 1.3 2013/06/05 10:33:14 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="A library for image plugins accross KDE applications."
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

PATCHES=( "${FILESDIR}/${PN}-4.10.0-uname.patch" )
