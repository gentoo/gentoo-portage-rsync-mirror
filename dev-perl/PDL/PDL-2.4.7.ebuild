# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDL/PDL-2.4.7.ebuild,v 1.7 2014/07/07 18:53:29 dilfridge Exp $

EAPI=2

MODULE_AUTHOR=CHM
inherit perl-module eutils multilib

DESCRIPTION="PDL Perl Module"

LICENSE="|| ( Artistic GPL-1+ ) public-domain PerlDL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="badval fftw gsl"

DEPEND=">=sys-libs/ncurses-5.2
	dev-perl/Filter
	virtual/perl-File-Spec
	virtual/perl-PodParser
	dev-perl/Inline
	dev-perl/Astro-FITS-Header
	>=dev-perl/ExtUtils-F77-1.13
	virtual/perl-Text-Balanced
	dev-perl/Term-ReadLine-Perl
	gsl? ( sci-libs/gsl )
	fftw? ( sci-libs/fftw:2.1 )"
	#opengl? ( virtual/opengl virtual/glu )

mydoc="DEPENDENCIES DEVELOPMENT MANIFEST* Release_Notes TODO"

SRC_TEST="do"

MAKEOPTS+=" -j1" #300272

src_prepare() {
	epatch "${FILESDIR}/PDL-2.4.2-makemakerfix.patch"

	# Unconditional -fPIC for the lib (#55238, #180807, #250335)
	epatch "${FILESDIR}/${PN}-2.4.4-PIC.patch"

	# TODO: everything in this function below this
	# TODO: line really belongs in src_compile() :

	# This 'fix' breaks compiles for non-opengl users
	#if ! use opengl ; then
	#	sed -e "s:WITH_3D => undef:WITH_3D => 0:" \
	#		${FILESDIR}/perldl.conf > ${S}/perldl.conf
	#fi
	sed -i \
		-e "s:WITH_HDF => undef:WITH_HDF => 0:" \
		-e "s:USE_POGL => undef:USE_POGL => 0:" \
		-e "s:WITH_3D => undef:WITH_3D => 0:" "${S}/perldl.conf" || die

	if use badval ; then
		sed -i -e "s:WITH_BADVAL => 0:WITH_BADVAL => 1:" "${S}/perldl.conf" || die
	fi

	# Turn off GSL automagic:
	if use gsl ; then
		sed -i -e "s:WITH_GSL => undef:WITH_GSL => 1:" "${S}/perldl.conf" || die
	else
		sed -i -e "s:WITH_GSL => undef:WITH_GSL => 0:" "${S}/perldl.conf" || die
	fi
	# Turn off FFTW automagic too:
	if use fftw ; then
		sed -i -e "s:WITH_FFTW => undef:WITH_FFTW => 1:" "${S}/perldl.conf" || die
	else
		sed -i -e "s:WITH_FFTW => undef:WITH_FFTW => 0:" "${S}/perldl.conf" || die
	fi
}

src_install() {
	perl-module_src_install

	cp "${S}"/Doc/{scantree.pl,mkhtmldoc.pl} "${D}"/${VENDOR_ARCH}/PDL/Doc/ || die
}

pkg_postinst() {
	if [[ ${ROOT} = / ]] ; then
		perl ${VENDOR_ARCH}/PDL/Doc/scantree.pl
		elog "Building perldl.db done. You can recreate this at any time"
		elog "by running"
	else
		elog "You must create perldl.db by running"
	fi
	elog "perl ${VENDOR_ARCH}/PDL/Doc/scantree.pl"
	elog "PDL requires that glx and dri support be enabled in"
	elog "your X configuration for certain parts of the graphics"
	elog "engine to work. See your X's documentation for futher"
	elog "information."
}
