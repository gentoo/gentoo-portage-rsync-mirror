# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netcomics-cvs/netcomics-cvs-0.14.1-r1.ebuild,v 1.1 2013/09/03 16:28:21 idella4 Exp $

EAPI=5

inherit perl-module cvs

ECVS_SERVER="netcomics.cvs.sourceforge.net:/cvsroot/netcomics"
ECVS_MODULE="netcomics"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="Program to download daily comics strips from web"
SRC_URI=""
HOMEPAGE="http://netcomics.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
# Warrants IUSE doc, adding
IUSE="doc"

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Parser"

src_install () {
	myinst="TMPDIR=${D}/var/spool/netcomics INSTALLSITELIB=${installvendorlib}"
	perl-module_src_install

	eval `perl '-V:installvendorlib'`
	BROKEN_FILES="/usr/bin/comicpage
			/usr/bin/netcomics
			/usr/bin/show_comics
			/usr/share/man/man1/netcomics.1
			${installvendorlib}/Netcomics/Config.pm"

	for f in $BROKEN_FILES ; do
	# get rid of /var/tmp/portage references:
	# files are installed in vendor_perl, not site_perl, change it too:
		sed -i -e "s:${D}::g" -e "s:site_perl:vendor_perl:g" "${D}"${f} || die "failure in sed statement"
	done

	if use doc; then
		dohtml -r doc/
	fi
}
