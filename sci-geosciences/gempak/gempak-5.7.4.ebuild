# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gempak/gempak-5.7.4.ebuild,v 1.9 2012/10/24 19:37:20 ulm Exp $

EAPI=1

inherit eutils

# They can't seem to retain a normal naming scheme, so hacks are required.
# Often the hacks change on every bump.
MY_PV="${PV/_}"
MY_P="${PN}_upc${MY_PV}"

DESCRIPTION="GEMPAK Meteorological Plotting and Analysis Package"
HOMEPAGE="http://www.unidata.ucar.edu/packages/gempak"
SRC_URI="${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RESTRICT="fetch"

DEPEND=">=x11-libs/motif-2.3:0"
RDEPEND="${DEPEND}"

# More inconsistencies, this sometimes changes on bumps.
S="${WORKDIR}/GEMPAK${MY_PV}"

pkg_setup() {
	# Define this here so we don't have to have it more than once.
	GENTOO_VARS="NAWIPS GARPHOME GARP_PATH NA_OS GEMPAK GEMPAKHOME GEMLIB GEMEXE
		GEMPDF GEMTBL GEMERR GEMHLP GEMMAPS GEMNTS GEMPARM GEMPTXT GEMGTXT
		NAWIPS_EXE NAWIPS_LIB NAWIPS_INC NAWIPS_HELP NAWIPS_TABLES NWX_TABLES
		NMAP_RESTORE MEL_BUFR MEL_BUFR_TABLES BRDGDIR xresources SCRIPTS_EXE
		GEMDATA OBS NTRANS_META TEXT_DATA SAT RAD RADDIR LDMDATA GOES8 GOES9 HDS
		MODEL SAO UPA RAW_SAO RAW_SYN RAW_UPA NLDN TORN_WARN TSTRM_WARN
		TEXT_WARN RBKGPH LP XUSERFILESEARCHPATH grids"
}

pkg_nofetch() {
	elog "Please visit ${HOMEPAGE}"
	elog "and place ${A} in ${DISTDIR}."
}

src_unpack() {
	setup_vars

	unpack ${A}

	ebegin "Applying miscellaneous fixes"
		# Add needed definition
		sed -e '/^GEMPAKHOME/iNAWIPS           = ${S}' ${FILESDIR}/Makeinc.common >> ${CONFIGDIR}/Makeinc.common

		# One of the GEMPAK cleanup scripts uses '$RM' instead of 'rm'.
		sed -i -e 's/^\$RM/rm/' ${S}/bin/scripts/cleanvgf

		# Eliminate bad symlink
		# rm ${S}/unidata/programs/gpnexr2/rsl_colors

		# This is necessary because otherwise it freaks out due to a missing
		# lib/linux.
		mkdir -p lib/linux
	eend 0

	# This is necessary because the paths to some bitmaps are hard-coded.
	# epatch ${FILESDIR}/${PV}-gui.c.patch

	# Fix changed header
	header_replace varargs.h stdarg.h

	# Can't install to /usr/local
	ebegin "Fixing bad install locations"
		for BADFILE in `grep -lr '/usr/local' ${S}`
			do sed -i "s:/usr/local:/usr:g" ${BADFILE} ;
		done
	eend 0
}

src_compile() {
	setup_vars

	make || die
}

src_install() {
	setup_vars

	einfo "Pre-installing GEMPAK..."
	make install || die

	# This eliminates all the Makefiles, source code, header files,
	# and sundry other useless files.
	ebegin "Removing unnecessary files"
		rm -rf ${S}/{config,include,ldm,lib,netcdf,nprogs,unidata,gempak/source}
		rm -rf ${S}/comet/{dcshef,etamap,garp/{gempak,gui,include,init,object,util}}
		rm ${S}/{,gempak/,comet/{,garp/}}Makefile
	eend 0

	# Create the directory to install GEMPAK to.
	dodir usr/gempak

	# Create the skeleton directory hierarchy for GEMPAK data.
	keepdir usr/gempak/data/images/radar/nids
	keepdir usr/gempak/data/images/sat/GOES-East
	keepdir usr/gempak/data/meta
	keepdir usr/gempak/data/model
	keepdir usr/gempak/data/nldn
	keepdir usr/gempak/data/nwx
	keepdir usr/gempak/data/redbook
	keepdir usr/gempak/data/surface
	keepdir usr/gempak/data/upperair
	dosym usr/gempak/data/model usr/gempak/data/model/hds
	dosym usr/gempak/data/model usr/gempak/data/model/hrs

	# Put all the necessary files in the correct place.
	einfo "Installing GEMPAK..."
	cp -Rfv ${S}/* ${D}/usr/gempak

	# This is necessary, because otherwise some of the files will not be
	# world-readable
	ebegin "Fixing permissions to ensure world-readability"
		chmod +r -Rf ${D}
	eend 0

	# Install env.d file
	newenvd ${FILESDIR}/gempak.env.d 10gempak
}

pkg_postinst() {
	einfo ""
	einfo "A skeleton directory hierarchy has been automatically"
	einfo "created in /usr/gempak/data.  If you wish to use a"
	einfo "different path you will need to edit /etc/env.d/10gempak"
	einfo "to reflect the change.  If you already have a directory"
	einfo "hierarchy of your own, then simply remove /usr/gempak/data"
	einfo "and create a symbolic link from your data path to"
	einfo "/usr/gempak/data.  Updates/uninstalls of GEMPAK will not"
	einfo "affect the symlinked directories, so long as they have data"
	einfo "inside them."
	einfo ""
	einfo "NOTE:  Some of the programs in the GEMPAK suite have paths"
	einfo "hardcoded into the executables. It is ill-advised"
	einfo "to start playing around with paths unless you know"
	einfo "what you are doing."
	einfo ""
}

header_replace() {
	# Replace obsoleted header
	# Usage: header_fix oldheader newheader
	ebegin "Replacing obsolete header references"
		for OLDFILE in `grep -lr "${1}" ${S}`
			do sed -i "s:${1}:${2}:g" ${OLDFILE} ;
		done
	eend 0
}

setup_vars() {
	# All GEMPAK paths need to be unset before attempting to compile.
	unset ${GENTOO_VARS}

	# These GEMPAK paths must be set to their new values before
	# compiling.
	export CONFIGDIR="${S}/config"
	export GARPHOME="${S}/comet/garp"
	export NA_OS="linux"
	export NAWIPS="${S}"
}
