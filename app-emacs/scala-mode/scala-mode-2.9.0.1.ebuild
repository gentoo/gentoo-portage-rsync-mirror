# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/scala-mode/scala-mode-2.9.0.1.ebuild,v 1.1 2011/06/07 08:10:36 ali_bush Exp $

EAPI=2

inherit elisp

MY_P="scala-tool-support-${PV}"
DESCRIPTION="Scala mode for Emacs"
HOMEPAGE="http://www.scala-lang.org/"
SRC_URI="http://www.scala-lang.org/downloads/distrib/files/scala-packages/${MY_P}.sbp -> ${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="dev-lang/scala"

S="${WORKDIR}/misc/scala-tool-support/emacs/"
SITEFILE="50${PN}-gentoo.el"
DOCS="AUTHORS FUTURE README"
