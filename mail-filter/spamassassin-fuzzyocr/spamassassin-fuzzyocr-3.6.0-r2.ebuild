# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamassassin-fuzzyocr/spamassassin-fuzzyocr-3.6.0-r2.ebuild,v 1.4 2014/08/04 20:37:02 zlogene Exp $

EAPI=5
inherit perl-module eutils user

MY_P="${P#spamassassin-}"

DESCRIPTION="SpamAssassin plugin for performing Optical Character Recognition (OCR) on attached images"
HOMEPAGE="http://fuzzyocr.own-hero.net/"
SRC_URI="http://users.own-hero.net/~decoder/fuzzyocr/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dbm gocr ocrad tesseract mysql logrotate amavis"

DEPEND="dev-lang/perl
		dev-perl/Tie-Cache
		>=mail-filter/spamassassin-3.2.0"

RDEPEND="${DEPEND}
	gocr? 		( >=app-text/gocr-0.43 )
	ocrad? 		( >=app-text/ocrad-0.14 )
	tesseract? 	( app-text/tesseract )
	!gocr? ( !ocrad? ( !tesseract? ( >=app-text/ocrad-0.14 ) ) )
	mysql? 		( dev-perl/DBD-mysql dev-perl/DBI )
	logrotate?	( app-admin/logrotate )
	dbm?		( virtual/perl-DB_File dev-perl/MLDBM-Sync virtual/perl-Storable )
	media-libs/netpbm[jpeg,png,tiff]
	media-libs/giflib
	dev-perl/String-Approx
	virtual/perl-Time-HiRes
	media-gfx/gifsicle"
#	postgres?	( dev-perl/DBD-Pg )

S="${WORKDIR}/${MY_P/fuzzyocr/FuzzyOcr}"

pkg_setup() {
	if ! use gocr && ! use ocrad && ! use tesseract ; then
		ewarn You did not specify an OCR engine. They can be
		ewarn enabled/disabled via the USE flags:
		ewarn gocr ocrad tesseract
		ewarn Defaulting to ocrad
	fi

	# create fuzzyocr group for logging and hashing
	if use dbm || use logrotate ; then
		use amavis || enewgroup fuzzyocr
	fi
}

src_prepare() {
		# Bug #174993
		epatch "${FILESDIR}"/${P}-fix_falsepositives.patch
		# Bug #273183
		epatch "${FILESDIR}"/${P}-fix_tmpdir.patch
		# Bug #313633
		epatch "${FILESDIR}"/${P}-untaint_ocr_helper.patch
		# Bug #330461
		epatch "${FILESDIR}"/${P}-fix_tesseract.patch

		# If no ocrad USE flag, remove it from Fuzzyocr.scansets / jni
		use ocrad || epatch "${FILESDIR}"/disableocrad.patch

		# If tesseract USE flag is set, enable it in Fuzzyocr.scansets /jni
		use tesseract && epatch "${FILESDIR}"/enabletesseract.patch

		# If gocr USE flag is unset, enable disable gocr in Fuzzyocr.scansets /jni
		use gocr || epatch "${FILESDIR}"/disablegocr.patch

		# Apply PgSQL patchset if USE postgres /juan
		#use postgres && epatch "${FILESDIR}"/postgresql.patch
}

src_install() {
		# called to get ${VENDOR_LIB}
		perlinfo

		local plugin_dir=${VENDOR_LIB}/Mail/SpamAssassin/Plugin

		insinto ${plugin_dir}
		doins FuzzyOcr.pm

		# Replace location of .pm file in config
		sed -ie "s:FuzzyOcr.pm:${plugin_dir}/FuzzyOcr.pm:" FuzzyOcr.cf

		# Enable logfile if logrotate
		if use logrotate ; then
			sed -ie "s:^#focr_verbose 3:focr_verbose 3:" FuzzyOcr.cf
			sed -ie "s:^#focr_logfile /tmp/FuzzyOcr.log:focr_logfile /var/log/FuzzyOcr.log:" FuzzyOcr.cf

			# Create the logfile with correct permissions /jni
			if [ ! -e /var/log/FuzzyOcr.log ]; then
				insinto /var/log
				newins /dev/null FuzzyOcr.log
				if use amavis ;  then
					fperms 600 /var/log/FuzzyOcr.log
					fowners	amavis:amavis /var/log/FuzzyOcr.log
				else
					fperms 660 /var/log/FuzzyOcr.log
					fowners root:fuzzyocr /var/log/FuzzyOcr.log
				fi
			fi

			diropts ""
			dodir /etc/logrotate.d
			insopts -m0644
			insinto /etc/logrotate.d
			newins "${FILESDIR}"/fuzzyocr.logrotate FuzzyOcr
		fi

		# Create needed dir for dbs and change FuzzyOcr.cf /jni
		if use dbm ; then
			dodir /var/lib/FuzzyOcr
			keepdir /var/lib/FuzzyOcr
			if use amavis ; then
				fowners amavis:amavis /var/lib/FuzzyOcr
				fperms 700 /var/lib/FuzzyOcr
			else
				fowners root:fuzzyocr /var/lib/FuzzyOcr
				fperms 770 /var/lib/FuzzyOcr
			fi

			sed -ie "s:^#focr_digest_db /etc/mail/spamassassin/FuzzyOcr.hashdb:#focr_digest_db /var/lib/FuzzyOcr/FuzzyOcr.hashdb:" FuzzyOcr.cf
			sed -ie "s:^#focr_db_hash /etc/mail/spamassassin/FuzzyOcr.db:#focr_db_hash /var/lib/FuzzyOcr/FuzzyOcr.db:" FuzzyOcr.cf
			sed -ie "s:^#focr_db_safe /etc/mail/spamassassin/FuzzyOcr.safe.db:#focr_db_safe /var/lib/FuzzyOcr/FuzzyOcr.safe.db:" FuzzyOcr.cf

			if ! use amavis ; then
				insinto /var/lib/FuzzyOcr/

				local hash_files="FuzzyOcr.hashdb FuzzyOcr.db FuzzyOcr.safe.db"

				for file in ${hash_files}; do
					if [ ! -e /var/lib/FuzzyOcr/${file} ]; then
						newins /dev/null ${file}
						fperms 660 /var/lib/FuzzyOcr/${file}
						fowners root:fuzzyocr /var/lib/FuzzyOcr/${file}
					fi
				done
			fi
		fi

		insinto /etc/mail/spamassassin/

		doins FuzzyOcr.cf
		doins FuzzyOcr.words
		doins FuzzyOcr.scansets
		doins FuzzyOcr.preps
		insinto ${VENDOR_LIB}/FuzzyOcr
		doins FuzzyOcr/*

		docinto samples
		dodoc samples/*
}

pkg_postinst() {
		elog "You need to restart spamassassin (as root) before this plugin will work:"
		elog "/etc/init.d/spamd restart"
		echo
		if use dbm || use logrotate ; then
			local files=""

			if use dbm ; then
				files="/var/lib/FuzzyOcr"
			fi

			if use logrotate ; then
				if [ -z ${files} ] ; then
					files="/var/log/FuzzyOcr.log"
				else
					files="${files} /var/log/FuzzyOcr.log"
				fi
			fi

			if use amavis ; then
				elog "All permissions are set for the user amavis!"
			else
				elog "Permissions have been set for the fuzzyocr group, to enable"
				elog "logging or hashing add any required users to this group"
			fi

			echo
			ewarn "If you run spamassassin as another user, please make sure to"
			ewarn "change permissions on" ${files/ / and }
			echo
		fi
}
