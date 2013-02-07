# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/keditfiletype/keditfiletype-4.9.5.ebuild,v 1.5 2013/02/07 01:11:32 naota Exp $

EAPI=4

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDE mime/file type assocciation editor"
KEYWORDS="amd64 ~arm ppc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

# test fails, last checked for 4.2.89
RESTRICT=test
