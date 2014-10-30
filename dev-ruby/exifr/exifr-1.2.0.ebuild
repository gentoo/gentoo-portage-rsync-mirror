# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/exifr/exifr-1.2.0.ebuild,v 1.2 2014/10/30 13:43:56 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_DOCDIR="doc/api"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A library to read EXIF info from JPEG and TIFF images"
HOMEPAGE="http://exifr.rubyforge.org/"

# License is not specified in source distribution but is in the GitHub
# repository.
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
