# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-fontutils/texlive-fontutils-2011.ebuild,v 1.11 2012/10/03 18:13:54 ulm Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="accfonts afm2pl epstopdf fontware lcdftypetools ps2pkm pstools psutils dvipsconfig fontinst fontools getafm t1utils collection-fontutils
"
TEXLIVE_MODULE_DOC_CONTENTS="accfonts.doc afm2pl.doc epstopdf.doc fontware.doc lcdftypetools.doc pstools.doc psutils.doc fontinst.doc fontools.doc getafm.doc t1utils.doc "
TEXLIVE_MODULE_SRC_CONTENTS="fontinst.source "
inherit  texlive-module
DESCRIPTION="TeXLive TeX and Outline font utilities"

LICENSE="GPL-2 GPL-1 LPPL-1.3 public-domain TeX-other-free"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
!dev-texlive/texlive-psutils
!<dev-texlive/texlive-fontsextra-2009
!<app-text/texlive-core-2009
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/accfonts/mkt1font texmf-dist/scripts/accfonts/vpl2ovp texmf-dist/scripts/accfonts/vpl2vpl texmf-dist/scripts/epstopdf/epstopdf.pl texmf-dist/scripts/fontools/afm2afm texmf-dist/scripts/fontools/autoinst texmf-dist/scripts/fontools/cmap2enc texmf-dist/scripts/fontools/font2afm texmf-dist/scripts/fontools/ot2kpx texmf-dist/scripts/fontools/pfm2kpx texmf-dist/scripts/fontools/showglyphs"
PATCHES=( "${FILESDIR}/epstopdf_invocation.patch" )
