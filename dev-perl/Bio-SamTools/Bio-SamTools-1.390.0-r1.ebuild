# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-SamTools/Bio-SamTools-1.390.0-r1.ebuild,v 1.1 2014/08/26 19:37:47 axs Exp $

EAPI=5

MODULE_AUTHOR=LDS
MODULE_VERSION=1.39
inherit perl-module

DESCRIPTION="Read SAM/BAM database files"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sci-biology/bioperl
	>=sci-biology/samtools-0.1.16"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-CBuilder
	virtual/perl-Module-Build
"

SRC_TEST=do

src_prepare() {
	sed \
		-e 's|my $HeaderFile = "bam.h";|my $HeaderFile = "bam/bam.h";|' \
		-e 's|my $LibFile    = "libbam.a";|my $LibFile    = "libbam.so";|' \
		-i Build.PL || die
	sed \
		-e 's|#include "bam.h"|#include "bam/bam.h"|' \
		-e 's|#include "sam.h"|#include "bam/sam.h"|' \
		-e 's|#include "khash.h"|#include "bam/khash.h"|' \
		-e 's|#include "faidx.h"|#include "bam/faidx.h"|' \
		-i lib/Bio/DB/Sam.xs c_bin/bam2bedgraph.c || die

	perl-module_src_prepare
}
