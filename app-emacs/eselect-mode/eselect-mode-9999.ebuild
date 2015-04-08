# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/eselect-mode/eselect-mode-9999.ebuild,v 1.5 2013/10/29 21:09:37 ulm Exp $

EAPI=5

MY_PN="eselect"
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/eselect.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${MY_PN}"

inherit elisp git-r3

DESCRIPTION="Emacs major mode for editing eselect files"
HOMEPAGE="http://wiki.gentoo.org/wiki/Project:Eselect"

LICENSE="GPL-2+"
SLOT="0"

S="${WORKDIR}/${MY_PN}/misc"
SITEFILE="50${PN}-gentoo.el"
