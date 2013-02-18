# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mutagen/mutagen-1.21.ebuild,v 1.1 2013/02/18 14:49:31 ssuominen Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Mutagen is an audio metadata tag reader and writer implemented in pure Python."
HOMEPAGE="http://code.google.com/p/mutagen http://pypi.python.org/pypi/mutagen"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

DOCS=( API-NOTES NEWS README TODO TUTORIAL )

#TODO: Backport DISTUTILS_SRC_TEST="setup.py" + deps from mutagen-1.20.ebuild
