# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/fsrunner/fsrunner-0.7.5.ebuild,v 1.1 2013/06/17 23:26:00 creffett Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="FSRunner give you instant access to any file or directory you need."
HOMEPAGE="http://code.google.com/p/fsrunner/"
SRC_URI="http://fsrunner.googlecode.com/files/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DOCS=( changelog README )
