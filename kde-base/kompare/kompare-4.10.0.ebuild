# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kompare/kompare-4.10.0.ebuild,v 1.2 2013/02/23 16:47:13 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdesdk"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Kompare is a program to view the differences between files."
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
