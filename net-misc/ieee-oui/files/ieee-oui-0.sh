#!/bin/sh
# Copyright 2012-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2
# Author:  Ian Stakenvicius <axs@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ieee-oui/files/ieee-oui-0.sh,v 1.1 2012/09/05 20:56:58 axs Exp $

OUI_SRC="http://standards.ieee.org/regauth/oui/oui.txt"
OUI_DEST="/var/lib/misc/oui.txt"

if ! wget -o /tmp/ieee-oui.wget -O ${OUI_DEST} ${OUI_SRC} ; then
	logger -t 'cron.weekly/ieee-oui' "failed to download update from ${OUI_SRC}, see /tmp/ieee-oui.wget for more info"
fi
