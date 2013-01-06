# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/git-deploy/git-deploy-20120202.ebuild,v 1.1 2012/02/10 20:27:25 idl0r Exp $

EAPI=4

inherit perl-app

DESCRIPTION="make deployments so easy that you'll let new hires do them on their
first day"
HOMEPAGE="https://github.com/git-deploy/git-deploy"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-lang/perl
	test? (
		dev-vcs/git
		virtual/perl-File-Temp
		perl-core/File-Spec
		)"
RDEPEND="dev-lang/perl
	dev-vcs/git
	perl-core/File-Spec
	virtual/perl-Getopt-Long
	virtual/perl-Term-ANSIColor
	virtual/perl-Time-HiRes"

src_prepare() {
	pod2man -n git-deploy README.pod > git-deploy.1 || die
}

src_test() {
	local testdir=${TMPDIR}/git-deploy-test

	# Prepare for tests
	cp -a "${S}/" $testdir || die
	cd $testdir || die

	git config --global user.name "git-deploy" || die
	git config --global user.email "git-deploy@localhost" || die

	git init . || die
	git add . || die
	git commit -a -m 'git-deploy testing' || die

	USER="git-deploy" perl t/run.t || die
}

src_install() {
	dobin git-deploy

	insinto $VENDOR_LIB
	doins -r lib/Git

	doman git-deploy.1
}
