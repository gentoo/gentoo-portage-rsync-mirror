# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/simple-rss/simple-rss-1.2.3-r1.ebuild,v 1.6 2014/10/30 14:00:27 mrueg Exp $

EAPI=4
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="html"
RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="A simple, flexible, extensible, and liberal RSS and Atom reader for Ruby"
HOMEPAGE="http://simple-rss.rubyforge.org/"
LICENSE="LGPL-2"

KEYWORDS="amd64 x86 ~x86-macos"
SLOT="0"
IUSE=""

RUBY_PATCHES=( "${P}-no-media-rss.patch" )
