# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/fbless/fbless-9999.ebuild,v 1.1 2012/07/18 06:11:42 yngwin Exp $

EAPI=4
PYTHON_COMPAT="python2_7"
inherit python-distutils-ng git-2

DESCRIPTION="Python-based console fb2 reader with less-like interface"
HOMEPAGE="https://github.com/matimatik/fbless"
EGIT_REPO_URI="git://github.com/matimatik/fbless.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/python:2.7[ncurses,xml]"
RDEPEND="${DEPEND}"
