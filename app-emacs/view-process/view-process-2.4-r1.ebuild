# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/view-process/view-process-2.4-r1.ebuild,v 1.12 2008/08/27 13:55:22 ulm Exp $

inherit elisp

DESCRIPTION="A Elisp package for viewing and operating on the process list"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ViewProcess"
SRC_URI="ftp://sunsite.unc.edu/pub/Linux/apps/editors/emacs/hm--view-process-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

S="${WORKDIR}/view-process-mode"
SITEFILE=50hm--view-process-gentoo.el
DOCS="ANNOUNCEMENT INSTALL LSM README"
