# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/eselect-mode/eselect-mode-9999.ebuild,v 1.1 2013/07/14 11:07:54 ulm Exp $

EAPI=5

MY_PN="eselect"
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/eselect.git"
EGIT_SOURCEDIR="${WORKDIR}/${MY_PN}"

inherit elisp git-2

DESCRIPTION="Emacs major mode for editing eselect files"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Eselect"

LICENSE="GPL-2+"
SLOT="0"

S="${WORKDIR}/${MY_PN}/misc"
SITEFILE="50${PN}-gentoo.el"
