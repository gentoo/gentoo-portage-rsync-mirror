# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/plist/plist-3.1.0-r1.ebuild,v 1.1 2013/10/30 03:58:25 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A library to manipulate Property List files, also known as plists"
HOMEPAGE="http://plist.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RUBY_PATCHES=( "${FILESDIR}"/${P}-nordoc.patch )
