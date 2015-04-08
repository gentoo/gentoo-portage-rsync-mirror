# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rainbow/rainbow-1.1.4.ebuild,v 1.11 2014/11/11 11:08:27 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="Changelog README.markdown"

inherit ruby-fakegem

DESCRIPTION="Extends ruby's String class with colored text on ANSI terminals"
HOMEPAGE="http://github.com/sickill/rainbow"

SRC_URI="https://github.com/sickill/rainbow/archive/v${PV}.tar.gz -> ${PN}-git-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE=""
